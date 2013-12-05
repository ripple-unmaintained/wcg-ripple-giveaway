class Fixnum
  def with_delimiter(delimiter=",", separator=".")
    number = self
    begin
      parts = self.to_s.split('.')
      parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
      parts.join separator
    rescue
     self
    end
  end
end