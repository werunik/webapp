SparkPostRails.configure do |c|
  c.sandbox = false
  c.track_opens = true
  c.track_clicks = true
  c.return_path = 'hi@werunik.com'
  c.campaign_id = 'Werunik'
  c.transactional = true
end