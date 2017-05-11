class BootstrapTable

  attr_reader :request, :start, :per_page

  def initialize(request)
    @request = request
  end

  def json(start: 0, per_page: 25)
    @start = start
    @per_page = per_page
    @per_page = 25 if @per_page = 0
    Rails.logger.debug sql
    ActiveRecord::Base.connection.select_value(sql)
  end

  def to_csv(attributes)
    all = ActiveRecord::Base.connection.execute(request)
    CSV.generate(headers: true, col_sep: "\t") do |csv|
      csv << attributes

      all.each do |item|
        csv << attributes.map{ |attr| item[attr.to_s] }
      end
    end

  end


  private

  def sql
    "with
    base_request as (
      #{request}
    )
  select row_to_json(t) from (
    select
    ( select count(*) from base_request) as total,
      (
        select array_to_json(array_agg(row_to_json(u)))
        from (
           select * from base_request offset #{start} limit #{per_page}
        ) u
      ) as rows
  ) t"
  end

end