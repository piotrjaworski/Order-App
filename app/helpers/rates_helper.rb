module RatesHelper

  def rate(object)
    @rate = object.rates.average(:score)
  end

end
