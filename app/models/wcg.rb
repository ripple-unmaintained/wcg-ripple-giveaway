require 'open-uri'

module Wcg
  class ServiceUnavailable < Exception; end
  class << self
  	def get_team(opts={})
      if opts[:cached]
        team = REDIS.get('wcg_ripple_team')
        if !team.nil? && !team.empty?
          JSON.parse(team)
        else
          parse_and_set_team
        end
      else
        parse_and_set_team
      end
  	end

    def parse_and_set_team
      team = Nokogiri::XML(open(team_url(1, total_team_members + 1))).css('TeamMember').map do |member|
        parse_member(member)
      end
      REDIS.set('wcg_ripple_team', team.to_json)
      team
    end

    def total_hours
      self.get_team(cached: true).collect{|m| Wcg.parse_stats(m) }.reject(&:nil?).inject(0) {|sum, s| sum + s['RunTime'].to_f} / 60 / 60
    end

    def verify_user(username, verification_code)
      username = URI.escape(username)
      verification_code = URI.escape(verification_code)
      url = "https://secure.worldcommunitygrid.org/verifyMember.do?name=#{username}&code=#{verification_code}"
      response = WcgApi.get(url).parsed_response
      if response['Error']
        false
      elsif response['unavailable']
        raise WcgServiceUnavailable
      else
        { member_id: response['MemberStatsWithTeamHistory']['MemberStats']['MemberStat']['MemberId'],
          username: response['MemberStatsWithTeamHistory']['MemberStats']['MemberStat']['Name'],
          team_id: (response['MemberStatsWithTeamHistory']['MemberStats']['MemberStat']['TeamId'] || nil)
        }
      end
    end

    def parse_stats(member)
      if member['stats'].empty?
        return nil
      else
        stats = {}
        member['stats'].each do |stat|
          key = stat.keys[0]
          stats[key] = stat[key]
        end
        stats
      end
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
