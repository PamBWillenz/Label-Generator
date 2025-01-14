class LabelGenerator
  LABEL_TYPES = {
    "Avery 5160" => "Avery5160",
    "Avery 5161" => "Avery5161",
    "Avery 5162" => "Avery5162"
  }

  def initialize(list, label_type = "Avery5160")
    @list = list
    @label_type = LABEL_TYPES[label_type] || label_type
  end

  def generate
    raise "Label Type Unknown '#{@label_type}'" unless Prawn::Labels.types.include?(@label_type)
    
    Prawn::Labels.generate("labels.pdf", @list.contacts, type: @label_type) do |pdf, contact|
      pdf.font_size 10
      pdf.text contact.full_name
      pdf.text contact.full_address
    end
  end
end