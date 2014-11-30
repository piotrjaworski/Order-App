class EmptyErrorPdf < Prawn::Document

  def initialize
    super(top_margin: 70)
    date = DateTime.now
    text ("There are not orders yet!")
    move_down 14
    fill_color "ff0000"
    move_down 20
    fill_color "0000ff"
    text date.strftime("Raport generated at %F %I:%M%p"), size: 10
  end
end
