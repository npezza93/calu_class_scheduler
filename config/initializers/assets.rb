# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(date.min.js schedules2.js courses.js curriculum_categories.js curriculum_category_sets.js majors.js needed_courses.js offerings.js password_resets.js schedule_approvals.js schedules.js semesters.js transcripts.js users.js work_schedules.js sessions.js )