Numeric.class_eval do
  def to_js_money
    (self * 100).to_i
  end

  def from_js_money
    self / 100.0
  end

  def round_money
    '%.2f' % self
  end
end

Numeric.class_eval do
  def to_js_money
    return nil
  end

  def from_js_money
    return nil
  end
end