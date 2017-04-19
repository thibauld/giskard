# encoding: utf-8

=begin
   Copyright 2016 Telegraph-ai

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
=end

module Giskard
	class Db
		@@db=nil
		@@queries={}

		def initialize
			return unless defined? PGNAME_LIVE
			pgpwd=::DEBUG ? ::PGPWD_TEST : ::PGPWD_LIVE
			pgname=::DEBUG ? ::PGNAME_TEST : ::PGNAME_LIVE
			pguser=::DEBUG ? ::PGUSER_TEST : ::PGUSER_LIVE
			pghost=::DEBUG ? ::PGHOST_TEST : ::PGHOST_LIVE
			if ::DEBUG then
				pgpwd=::PGPWD_LIVE
				pgname=::PGNAME_LIVE
				pguser=::PGUSER_LIVE
				pghost=::PGHOST_LIVE
			end
			Bot.log.debug "connect to database : #{pgname} with user : #{pguser}"
			@@db=::PG.connect(
				"dbname"=>pgname,
				"user"=>pguser,
				"password"=>pgpwd,
				"host"=>pghost, 
				"port"=>::PGPORT
			)
		end

		def self.load_queries
			Giskard::Core::User.load_queries
			Giskard::FB::User.load_queries
			Giskard::TG::User.load_queries
		end

		def prepare(name,query)
			@@queries[name]=query
		end

		def self.close
			@@db.close() unless @@db.nil?
		end

		def query(name,params)
			Bot.log.info "#{__method__}: #{name} / values: #{params}"
			begin
				res=@@db.exec_params(@@queries[name],params)
			rescue ::PG::Error=>e
				Bot.log.error "DB Error: #{e}"
			end
			return res
		end
	end
end
