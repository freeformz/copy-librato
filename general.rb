
def url_for(user)
  "https://#{user.split(":").map {|i| CGI.escape(i)}.join(":")}@#{BASE}"
end

def strip(hsh, what)
  hsh.inject(Hash.new()) do |m,(k,v)|
    if v.is_a?(Hash)
      m[k] = strip(v, what)
    elsif v.is_a?(Array)
      m[k] = []
      v.each do |item|
        m[k] << if item.is_a?(Hash)
                  strip(item, what)
                else
                  item
                end
      end
    elsif !what.include?(k)
      m[k] = v
    end
    m
  end
end
