require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone)
  phone = phone.gsub(/\D/, '') # Remove non-numeric characters
  if phone.length < 10 || phone.length > 11 || (phone.length == 11 && phone[0] != '1')
    'Invalid phone number'
  elsif phone.length == 11 && phone[0] == '1'
    phone[1..-1] # Trim the leading 1
  else
    phone # Valid 10-digit number
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('../output') unless Dir.exist?('../output')

  filename = "../output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def find_peak_registration_hours(contents)
  hours = Hash.new(0)
  contents.each do |row|
    reg_date = row[:regdate]
    next if reg_date.nil? || reg_date.empty?

    begin
      time = Time.strptime(reg_date, "%m/%d/%y %H:%M")
      hours[time.hour] += 1
    rescue ArgumentError
      puts "Invalid date format for row #{row}"
    end
  end

  if hours.empty?
    puts "No valid registration dates found."
  else
    peak_hour = hours.max_by { |hour, count| count }[0]
    puts "Peak registration hour: #{peak_hour}"
  end
end

def find_peak_registration_days(contents)
  days = Hash.new(0)
  contents.each do |row|
    reg_date = row[:regdate]
    next if reg_date.nil? || reg_date.empty?

    begin
      time = Time.strptime(reg_date, "%m/%d/%y %H:%M")
      day_of_week = time.strftime("%A")
      days[day_of_week] += 1
    rescue ArgumentError
      puts "Invalid date format for row #{row}"
    end
  end

  if days.empty?
    puts "No valid registration dates found."
  else
    peak_day = days.max_by { |day, count| count }[0]
    puts "Peak registration day: #{peak_day}"
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  '../event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('../form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

# Find peak registration hours and days
find_peak_registration_hours(contents)
find_peak_registration_days(contents)
