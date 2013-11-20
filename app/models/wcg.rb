require 'open-uri'

module Wcg
  class << self
  	def get_team
      Nokogiri::XML(open(team_url(1, total_team_members + 1))).css('TeamMember').map do |member|
        parse_member(member)
      end
  	end

  private
    def total_team_members
      doc = Nokogiri::HTML(open team_url(1, 50, false))
      /(\d+)/.match(doc.css('.contentTextBold+ .contentText').children.last.text)[1].to_i
    end

    def team_url(page, per_page, xml=true)
      url = 'https://secure.worldcommunitygrid.org/team/viewTeamMemberDetail.do'
      url << '?sort=name&teamId=0QGNJ4D832'
      url << "&pageNum=#{page}"
      url << "&numRecordsPerPage=#{per_page}"
      url << "&xml=#{xml}"
    end

    def parse_member(member_xml)
      Hash.new.tap do |hash|
        member_id = member_xml.elements.select {|el| el.name == "MemberId" }[0]
        name = member_xml.elements.select {|el| el.name == "Name" }[0]

        hash['id'] = member_id.children.first.text.strip
        hash['name'] = name.children.first.text.strip
        hash['stats'] = parse_member_stats(member_xml)
      end
    end

    def parse_member_stats(member_xml)
      stats = member_xml.elements.select {|el| el.name == "StatisticsTotals" }[0]
      puts stats.children.map &:name
      stats = stats.children.map {|child| { child.name.to_sym => child.text.strip } }
      stats.select! {|st| st.keys[0].to_s.strip != "text" }
    end
  end
end
