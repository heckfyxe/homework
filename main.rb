require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'train_type'

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def launch
    loop do
      show_command_list
      print 'Введите команду: '
      command = gets.chomp
      execute_command(command)
      puts
    end
  end

  # Main class needs launch method only
  # Other methods are internal implementation
  # So they are private
  private

  def show_command_list
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать маршрут'
    puts '4. Добавить станцию в маршрут'
    puts '5. Удалить станцию из маршрута'
    puts '6. Назначить маршрут поезду'
    puts '7. Добавить вагон к поезду'
    puts '8. Отцепить вагон от поезда'
    puts '9. Переместить поезд'
    puts '10. Показать список станций'
    puts '11. Показать список поездов на станции'
  end

  def execute_command(command)
    case command
    when '1'
      create_station
    when '2'
      create_train
    when '3'
      create_route
    when '4'
      add_station_to_route
    when '5'
      remove_station_from_route
    when '6'
      set_route_for_train
    when '7'
      attach_carriage
    when '8'
      detach_carriage
    when '9'
      move_train
    when '10'
      show_stations
    when '11'
      show_trains_of_station
    else
      puts 'Неизвестная команда'
    end
  end

  def find_station(displaying_text = 'Введите название станции: ')
    print displaying_text
    station_name = gets.chomp
    station = @stations.select { |s| s.name == station_name }.first
    puts 'Не найдено станции с таким названием' if station.nil?
    station
  end

  def find_route
    start_station = find_station('Введите начальную станцию маршрута: ')
    end_station = find_station('Введите конечную станцию маршрута: ')
    route = @routes.select { |r| r.stations.first == start_station && r.stations.last == end_station }.first
    puts 'Не найдено такого маршрута' if route.nil?
    route
  end

  def find_train
    print 'Введите номер поезда: '
    train_number = gets.chomp
    train = @trains.select { |t| t.number == train_number }.first
    puts 'Не найден поезд с таким номером' if train.nil?
    train
  end

  def find_station_and_route
    station = find_station
    return if station.nil?

    route = find_route
    return if route.nil?

    [station, route]
  end

  # 1.
  def create_station
    print 'Введите название станции: '
    name = gets.chomp
    station = Station.new(name)
    @stations << station
  end

  # 2.
  def create_train
    print 'Введите номер поезда: '
    number = gets.chomp
    print 'Введите тип поезда: '
    type = gets.chomp
    train = case type
            when TrainType::PASSENGER
              PassengerTrain.new(number)
            when TrainType::CARGO
              CargoTrain.new(number)
            else
              puts 'Неправильный тип поезда'
              return
            end
    @trains << train
  end

  # 3.
  def create_route
    start_station = find_station('Введите название начальной станции: ')
    return if start_station.nil?

    end_station = find_station('Введите название конечной станции: ')
    return if end_station.nil?

    route = Route.new(start_station, end_station)
    @routes << route
  end

  # 4.
  def add_station_to_route
    station, route = find_station_and_route
    return if station.nil? || route.nil?

    route.add(station)
  end

  # 5.
  def remove_station_from_route
    station, route = find_station_and_route
    return if station.nil? || route.nil?

    route.delete(station)
  end

  # 6.
  def set_route_for_train
    train = find_train
    return if train.nil?

    route = find_route
    return if route.nil?

    train.route = route
  end

  # 7.
  def attach_carriage
    train = find_train
    return if train.nil?

    carriage = case train.type
               when TrainType::PASSENGER
                 PassengerCarriage.new
               when TrainType::CARGO
                 CargoCarriage.new
               else
                 puts 'Неизвестный тип поезда'
                 return
               end
    train.attach_carriage(carriage)
  end

  # 8.
  def detach_carriage
    train = find_train
    return if train.nil?

    train.detach_carriage
  end

  # 9.
  def move_train
    train = find_train
    return if train.nil?

    puts '1. Вперёд'
    puts '2. Назад'
    direction = gets.chomp
    case direction
    when '1'
      train.to_forward
    when '2'
      train.to_back
    else
      puts 'Неизвестная команда'
    end
  end

  # 10.
  def show_stations
    @stations.each { |station| puts station.name }
  end

  # 11.
  def show_trains_of_station
    station = find_station
    return if station.nil?

    station.trains.each { |train| puts train.number }
  end
end

Main.new.launch
