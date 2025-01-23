class LabelGenerator
  LABEL_TYPES = {
    "Avery 5160" => "Avery5160",
    "Avery 7160" => "Avery7160",
    "Avery 7165" => "Avery7165"
  }

  def initialize(list, label_type = "Avery5160")
    @list = list
    @label_type = LABEL_TYPES[label_type] || label_type
    puts "Using label type: #{@label_type}"
    puts "Available types: #{Prawn::Labels.types.keys}"
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