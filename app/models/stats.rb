class Stats
  def self.global
    { rate: 40.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse,
      today: 300_000.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse,
      total_hours: 99_837_787.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse,
      total_xrp: 102_019_760.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    }
  end
end
