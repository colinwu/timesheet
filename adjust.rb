### Adjust atart_at and end_at fields to account for timezone
Project.all.each do |p|
  p.events.each do |e|
    tz = 4 if e.start_at.zone == 'EDT'
    tz = 5 if e.start_at.zone == 'EST'
    e.start_at = e.start_at + tz * 3600
    unless e.end_at.nil?
      tz = 4 if e.end_at.zone == 'EDT'
      tz = 5 if e.end_at.zone == 'EST'
      e.end_at = e.end_at + tz * 3600
    end
    e.save
  end
end
