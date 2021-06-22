class DynamodbController < ApplicationController

  DEMO_USER = 'admin@example.com'
  DEMO_USER2 = 'admin2@example.com'
  TABLE_NAME = 'JournallyTable'
  TABLE = Aws::DynamoDB::Table.new(TABLE_NAME, client: DYNAMODB_CLIENT)

  #
  # GET /dynamodb
  #
  def index
    # 今日
    date = Date.today.strftime('%Y%m%d')

    # データ削除
    # TABLE.delete_item(key: {
    #                         pk: "jd##{date}",
    #                         sk: DEMO_USER,
    #                   })

    #
    # 日報登録
    #
    [DEMO_USER, DEMO_USER2].each do |user|
      # 日報親登録
      TABLE.put_item(
        item: {
          pk: "j##{date}",
          sk: user,
          note: "所感 #{randstr}", #
          secret: "本当は暗号化してBASE64化する",
          leave_flag: true,
          created_at: Time.now.to_i,
          updated_at: Time.now.to_i,
        }
      )

      # 日報子1 登録
      TABLE.put_item(
        item: {
          pk: "jd##{user}##{date}",
          sk: '1000',
          note: "定例朝会",
          end_time: '1030',
          category_id: 1,
          created_at: Time.now.to_i,
          updated_at: Time.now.to_i,
        }
      )
      # 日報子2 登録
      TABLE.put_item(
        item: {
          pk: "jd##{user}##{date}",
          sk: '1030',
          note: "リリース確認",
          end_time: '1100',
          category_id: 1,
          created_at: Time.now.to_i,
          updated_at: Time.now.to_i,
        }
      )
    end

    # 日報親取得
    @diary = TABLE.get_item(key: { pk: "j##{date}", sk: DEMO_USER })


    # 日報子（複数）取得
    @diary_details = TABLE.query(
      scan_index_forward: true, # sort key の昇順
      key_condition_expression: "pk = :pk",
      expression_attribute_values: {
        ':pk': "jd##{DEMO_USER}##{date}",
      }
    )

    # 特定の日の複数ユーザの日報取得
    # Table には batch_get_item メソッドがないので client から呼び出す
    multiple_keys = [DEMO_USER, DEMO_USER2].map do |user|
      {pk: "j##{date}", sk: user}
    end

    @diaries = DYNAMODB_CLIENT.batch_get_item(
      request_items: {
        TABLE_NAME => {
          keys: multiple_keys
        }
      }
    )

  end

  def randstr
    SecureRandom.hex(12)
  end

end
