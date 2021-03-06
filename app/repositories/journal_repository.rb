# frozen_string_literal: true

#
# 日報データを取得・更新する用リポジトリ
#
class JournalRepository < ApplicationRepository

  class << self

    # TODO: 直接ハッシュを生成しているので一旦 rubocop を止める
    # rubocop:disable Metrics/MethodLength:
    def list(_user_email, _date)
      # 日報の検索処理
      #
      [{
        user_email:  'ishida@ingage.jp',
        date:        '20210527',
        memo:        'xxxxxx',
        secret_memo: 'yyyyy',
        leave_flag:  false,
      }, {
        user_email:  'nagata@ingage.jp',
        date:        '20210527',
        memo:        'aaaaaaa',
        secret_memo: 'bbbbbbbb',
        leave_flag:  false,
      }]
    end
    # rubocop:enable Metrics/MethodLength:

    def find(user_email:, date:)
      # 日報の検索（1件取得）処理
    end

    def create
      # 日報の作成処理
    end

    def destroy(user_email:, date:)
      # 日報の削除処理
    end

  end

end
