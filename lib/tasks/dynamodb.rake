#
# docker-compose run web bundle exec rails dynamodb:create_table
#
namespace :dynamodb do
  desc 'テーブル作成'
  task create_table: :environment do |t|
    table_name = "JournallyTable"
    table_def = {
      table_name: table_name,
      key_schema: [
        { attribute_name: "pk", key_type: "HASH" },
        { attribute_name: "sk", key_type: "RANGE" }
      ],
      attribute_definitions: [
        { attribute_name: "pk",           attribute_type: "S" },
        { attribute_name: "sk",           attribute_type: "S" },
      ],
#      global_secondary_indexes: [],
      provisioned_throughput: {
        read_capacity_units:  1,
        write_capacity_units: 1,
      }
    }

    #
    # もし間違えて作ったのであれば以下を有効にして削除してください
    #
    # begin
    #   resp = DYNAMODB_CLIENT.delete_table({ table_name: table_name })
    #   p resp
    # rescue Aws::DynamoDB::Errors::ResourceNotFoundException => e
    #   p e.message
    # end

    resp = DYNAMODB_CLIENT.create_table(table_def)
    p ""
    p resp

  end
end
