class Item

  attr_reader :title, :description, :price

  def initialize(params = {})
    @title = params[:title]
    @description = params[:description]
    @price = params[:price]
  end
end


class AbstractReport

  attr_reader :title, :items

  def initialize(params = {})
    @title = params[:title]
    @items = params[:items]

  end


  def create_report
    main_template
      .gsub(/%items_placeholder%/, items_string_array.join(joiner))
      .gsub(/%report_title%/, title)

  end

  private

    def items_string_array
      items.map do |item|
        item_template
            .gsub(/%title%/, item.title)
            .gsub(/%description%/, item.description)
            .gsub(/%price%/, item.price)
      end
    end

    def joiner
      ''
    end


    def main_template
      rails 'Called abstract method Main Template'
    end

    def item_template
      rails 'Called abstract method Item Template'
    end

end


class TextReport < AbstractReport

  def main_template
    [
        'Text Report.',
        'Report title: %report_title%',
        'Item are:',
        '%items_placeholder%'
    ].join("\n")
  end

  def item_template
    [
        'Item:',
        "title: '%title%',",
        "description: '%description%',",
        "price: '%price%'\n"
    ].join("\n")
  end

end



class JSONReport < AbstractReport

  def main_template
    "{\"type\":\"JSON Report\",\"title\":\"%report_title%\",\"items\":[%items_placeholder%]}"
  end

  def item_template
    "{\"title\":\"%title%\",\"description\":\"%description%\",\"price\":\"%price%\"}"
  end

  def joiner
    ','
  end

end


class HTMLReport < AbstractReport

  def main_template

    [
        '<!DOCTYPE html>',
        '<html>',
        ' <head>',
        '  <meta charset="utf-8">',
        '  <title>%report_title%</title>',
        ' </head>',
        ' <body>',
        '  <div>',
        '    %items_placeholder%',
        '  </div>',
        ' </body>',
        '</html>'
    ].join("\n")

  end

  def item_template
    [
        '<p>',
        '      <span>title: %title%</span>',
        '      <span>description: %description%</span>',
        '      <span>price: %price%</span>',
        "    <p>"
    ].join("\n")
  end


end

PARAMS = {
    title: 'Report for 3 items',
    items: [
        Item.new(title: 'Item 1', description: 'It is not nice item', price: '10'),
        Item.new(title: 'Item 2', description: 'Not bad', price: '20'),
        Item.new(title: 'Item 3', description: 'Very good item', price: '30')
    ]
}

puts TextReport.new(PARAMS).create_report
puts "-----------------------------------"
puts JSONReport.new(PARAMS).create_report
puts "-----------------------------------"
puts HTMLReport.new(PARAMS).create_report
