require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'json'
require 'pry'

namespace :scrape do
	desc "get university information from http://colleges.usnews.rankingsandreviews.com/"
	task university_rankings: :environment do
		page_number = 1	
		uri = "http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities/data"
		next_page = true
		agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
		colleges = Array.new
		mechanize_page = agent.get(uri)
		while !next_page.nil?
			puts "\n----------- Page #{page_number} -----------\n"			

			html = mechanize_page.body
			html_nokogiri_object = Nokogiri::HTML(html)
			rows = html_nokogiri_object.css("table.ranking-data-free tbody tr")

			rows.each_with_index do |row, index|
				college_name = row.css("td a.school-name").text
				tuition_fees = row.css("td.search_tuition_display").text.strip
				college_rank = row.css("td span.rankscore-bronze").text		
				total_enrollement = row.css("td.total_all_students").text.strip!
				accept_rate = row.css('td.r_c_accept_rate').text.strip!
				avg_freshman_retention = row.css('td.r_c_avg_pct_retention').text.strip!
				graduation_rate = row.css('td.r_c_avg_pct_grad_6yr').text.strip!
				graduation_rate = graduation_rate.split(' ')[0]
				college_rank = college_rank.split(' ')[0]
				accept_rate = accept_rate.split(' ')[0]
				avg_freshman_retention = avg_freshman_retention.split(' ')[0]
				college_hash = {name: college_name, tuition_fees: tuition_fees, rank: college_rank, total_enrollement: total_enrollement, acceptance_rate: accept_rate, average_retention_rates: avg_freshman_retention, graduation_rate: graduation_rate}
				colleges << college_hash
				college = College.new(college_hash)
				college.save!
				puts "INFO #{college_name}, #{tuition_fees}, #{college_rank}, #{total_enrollement}, #{accept_rate}, #{avg_freshman_retention}, #{graduation_rate}"
			end

			# next page
			next_page = mechanize_page.link_with(text: 'Next »')
			unless next_page.nil?
				mechanize_page = next_page.click
			else
				next_page = nil
			end	
			page_number = page_number + 1
		end
		# write json to file
 		File.open("public/colleges.json", "w") {|file| file.write(JSON.pretty_generate(colleges))}
	end 
end