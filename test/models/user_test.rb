# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  advisor                :boolean          default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#  advised_by             :integer
#  major_id               :integer
#  minor                  :text
#  first_name             :string(255)
#  last_name              :string(255)
#  class_standing         :string(255)
#  sat_520                :boolean
#  sat_580                :boolean
#  sat_440                :boolean
#  pt_a                   :integer
#  pt_b                   :integer
#  pt_c                   :integer
#  pt_d                   :integer
#  sat_640                :boolean
#  sat_700                :boolean
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#

require "test_helper"

class UserTest < ActiveSupport::TestCase
end
