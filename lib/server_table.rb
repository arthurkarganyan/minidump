class ServerTable
  attr_reader :scope, :params

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def call
    limit = (params[:limit] || 10).to_i
    page = (params[:page] || 1).to_i
    {data: scope.limit(limit).offset((page - 1) * limit).all.to_a, count: scope.count}
  end

end
