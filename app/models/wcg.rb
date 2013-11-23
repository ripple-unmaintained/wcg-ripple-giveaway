require 'open-uri'

module Wcg
  class << self
  	def get_team
      Nokogiri::XML(open(team_url(1, total_team_members + 1))).css('TeamMember').map do |member|
        parse_member(member)
      end
  	end

    def verify_user(username, verification_code)
      username = URI.escape(username)
      verification_code = URI.escape(verification_code)
      url = "https://secure.worldcommunitygrid.org/verifyMember.do?name=#{username}&code=#{verification_code}"
      response = HTTParty.get(url).parsed_response
      if response['Error']
        false
      elsif response['unavailable']
        raise WcgServiceUnavailable
      else
        { member_id: response['MemberStatsWithTeamHistory']['MemberStats']['MemberStat']['MemberId'],
          username: response['MemberStatsWithTeamHistory']['MemberStats']['MemberStat']['Name'] }
      end
    end

    def parse_stats(member)
      stats = {}
      member['stats'].each do |stat|
        key = stat.keys[0]
        stats[key] = stat[key]
      end
      stats
    end

    def get_team_member(name)
      member = get_team.select { |member| member['name'] == name }[0]
      member['stats'] = parse_stats(member)
      member
    end

  private
    def total_team_members
      doc = Nokogiri::HTML(open team_url(1, 50, false))
      begin
        /(\d+)/.match(doc.css('.contentTextBold+ .contentText').children.last.text)[1].to_i
      rescue
        raise WcgServiceUnavailable
      end
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
      stats = stats.children.map {|child| { child.name.to_sym => child.text.strip } }
      stats.select! {|st| st.keys[0].to_s.strip != "text" }
    end
  end
end
