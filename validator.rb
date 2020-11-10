module Validator
  def valid?
    valid!
    true
  rescue RuntimeError
    false
  end

  protected

  def valid!; end
end
