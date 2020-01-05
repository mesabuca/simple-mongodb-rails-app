class Book
  include Mongoid::Document
  field :name, type: String
  field :summary, type: String

  def save(options = {})
    if new_record?
      !insert(options).new_record?
    else
      update_document(options)
    end
  end

  def destroy(options = nil)
    raise Errors::ReadonlyDocument.new(self.class) if readonly?
    self.flagged_for_destroy = true
    result = run_callbacks(:destroy) { delete(options || {}) }
    self.flagged_for_destroy = false
    result
  end

  def update(attributes = {})
    assign_attributes(attributes)
    save
  end
end
