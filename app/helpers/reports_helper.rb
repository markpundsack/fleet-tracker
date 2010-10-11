module ReportsHelper
  def report_in_words(r)
    out = "#{r.char_name} in #{r.solar_system_name}"
    out += ", #{r.reds} reds" unless (r.reds.nil? || r.reds==0)
    out += ", #{r.neutrals} neuts" unless (r.neutrals.nil? || r.neutrals==0)
    out += ", clear" if r.clear?
    #out += "#{time_ago_in_words(r.updated_at)} ago"
    return out
  end
end
