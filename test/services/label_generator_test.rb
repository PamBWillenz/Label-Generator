require "test_helper"

class LabelGeneratorTest < ActiveSupport::TestCase
  def setup
    @list = lists(:one)
    @label_generator = LabelGenerator.new(@list, "Avery5160")
  end

  test "should generate labels" do
    pdf = @label_generator.generate
    assert_not_nil pdf
    assert pdf.is_a?(String)
  end

  test "should raise error for unknown label type" do
    assert_raises(RuntimeError) do
      LabelGenerator.new(@list, "UnknownType").generate
    end
  end
end