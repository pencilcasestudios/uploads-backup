if ARGV[0] && ARGV[1]
	application_name = ARGV[0]
	s3_bucket_name = ARGV[1]

	dump_filename = Time.now.strftime("#{application_name.downcase}-%Y%m-%H")

	backup_file_path = "~/Projects/Backups/Uploads/#{application_name}"

	`mkdir -p #{backup_file_path}`
	`tar -zcvf #{backup_file_path}/#{dump_filename}.tar.gz /var/Apps/#{application_name}/production/shared/uploads/`
	`s3cmd --encrypt --verbose put #{backup_file_path}/#{dump_filename}.tar.gz s3://#{s3_bucket_name}`
else
	puts "Usage: #{__FILE__} <application> <s3bucket>"
end
