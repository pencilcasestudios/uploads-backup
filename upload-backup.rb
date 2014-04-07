if ARGV[0] && ARGV[1] && ARGV[2]
	application_name = ARGV[0]
	password = ARGV[1]
	s3_bucket_name = ARGV[2]

	dump_filename = Time.now.strftime("#{application_name.downcase}-%Y%m-%H")

	backup_file_path = "~/Projects/Backups/Uploads/#{application_name}"

	`mkdir -p #{backup_file_path}`
	`tar -zcvf #{backup_file_path}/#{dump_filename}.tar.gz /var/Apps/#{application_name}/production/shared/uploads/`
	`s3cmd --encrypt --verbose put #{backup_file_path}/#{dump_filename}.tar.gz s3://#{s3_bucket_name}`
else
	puts "Usage: #{__FILE__} <application> <password> <s3bucket>"
end
