module Subject

  def initialize
    @observers = []
  end

  def add_observer(event_type, observer)
    @observers << {event_type: event_type, observer: observer}
  end

  def delete_observer(event_type, observer)
    @observers.delete(event_type: event_type, observer: observer)
  end

  def notify_observers(event_type)
    selected_observers = @observers.select do |observer|
      observer[:event_type] == event_type
    end
    selected_observers.each do |observer|
      observer[:observer].update(self)
    end
  end

end


class Customer

  attr_reader :name


  def initialize(name)
    @name = name
    puts ''
    puts "Hello my name is #{@name}"
  end

  def update(changed_book)
    puts "#{self.class} #{name}: Yeah, I can buy a book '#{changed_book.title}'"
  end


  def buy_a_book(book)
    if book.sell_one_book!
      puts "#{name} bought a book"
    else
      puts "#{name} did not buy any books"
    end

  end


  private
    def sell_one_book!

    end

end