import axios, {
  AxiosInstance,
  AxiosError,
  CancelTokenSource,
  AxiosResponse,
  AxiosRequestConfig,
  AxiosTransformer,
} from 'axios';
import qs from 'qs';
import { useAppStore } from '@/stores/appStore';

export type DataType = {
  [key: string]: unknown;
};

export type ParamType = {
  [key: string]: unknown;
};

export type ConfigType = {
  cancelKey?: string;
  transformResponse?: AxiosTransformer;
};

export default class BaseResource {
  private axios: AxiosInstance;
  cancelSource: { [key: string]: CancelTokenSource | null };

  static getBaseHeaders(): { [key: string]: unknown } {
    const appStore = useAppStore();
    return {
      'x-requested-with': location.href,
      'x-csrf-token': appStore.csrfToken,
      'Content-Type': 'application/json',
    };
  }

  static stringify(query = {}): string {
    return qs.stringify(query, { indices: false });
  }

  static generateCancelSource(): CancelTokenSource {
    return axios.CancelToken.source();
  }

  constructor(baseURL: string, srcHeaders = {}) {
    const headers = Object.assign(BaseResource.getBaseHeaders(), srcHeaders);

    this.axios = axios.create({ baseURL, headers: headers });
    this.cancelSource = {};
  }

  protected async requestGet<T>(
    url = '/',
    params = {},
    config: ConfigType = {},
  ): Promise<AxiosResponse<T>> {
    const axiosConfig = this.generateAxiosConfig(config);

    const getUrl = `${url}?${BaseResource.stringify(params)}`;
    return this.axios
      .get<T>(getUrl, axiosConfig)
      .catch(this.postError.bind(this))
      .finally(() => {
        this.deleteCancelSource(config);
      });
  }

  protected async requestPost<T>(
    url = '/',
    data = {},
    config: ConfigType = {},
  ): Promise<AxiosResponse<T>> {
    const axiosConfig = this.generateAxiosConfig(config);

    return this.axios
      .post<T>(url, data, axiosConfig)
      .catch(this.postError.bind(this))
      .finally(() => {
        this.deleteCancelSource(config);
      });
  }

  protected async requestPut<T>(
    url = '/',
    data = {},
    config: ConfigType = {},
  ): Promise<AxiosResponse<T>> {
    const axiosConfig = this.generateAxiosConfig(config);

    return this.axios
      .put<T>(url, data, axiosConfig)
      .catch(this.postError.bind(this))
      .finally(() => {
        this.deleteCancelSource(config);
      });
  }

  protected async requestDelete<T>(url = '/', config: ConfigType = {}): Promise<AxiosResponse<T>> {
    const axiosConfig = this.generateAxiosConfig(config);

    return this.axios
      .delete<T>(url, axiosConfig)
      .catch(this.postError.bind(this))
      .finally(() => {
        this.deleteCancelSource(config);
      });
  }

  private generateAxiosConfig(config: ConfigType): AxiosRequestConfig {
    const axiosConfig = {} as AxiosRequestConfig;

    if (config.cancelKey) {
      this.cancelSource = this.cancelSource || {};
      axiosConfig.cancelToken = (
        this.cancelSource[config.cancelKey] || BaseResource.generateCancelSource()
      ).token;
    }
    if (config.transformResponse) {
      axiosConfig.transformResponse = [
        ...(axios.defaults.transformResponse as AxiosTransformer[]),
        config.transformResponse,
      ];
    }
    return axiosConfig;
  }

  private deleteCancelSource(config: ConfigType) {
    if (config.cancelKey) this.cancelSource[config.cancelKey] = null;
  }

  private postError(error: AxiosError) {
    if (axios.isCancel(error)) {
      console.log('canceled ajax for double submit... url: ' + error.request.url);
      return Promise.reject();
    } else {
      // なんかの共通エラー処理
      throw error;
    }
  }
}
