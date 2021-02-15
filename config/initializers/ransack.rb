Ransack.configure do |config|
  config.add_predicate 'lteq_end_of_day', arel_predicate: 'lteq', formatter: proc { |v| v.end_of_day } # 受け取った値をどうフォーマットするか
end
