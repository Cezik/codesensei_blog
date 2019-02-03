require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_inclusion_of(:role).in_array(['user', 'admin', 'editor'])



  # ['user', 'admin', 'editor'].each do |role|
  # test "is valid with '#{role}' role" do
  #   user = build :user, role: role
  #   assert_predicate user, :valid?
  # end

  # test 'is valid with "foo" role' do
  #   user = build :user, role: 'foo'
  #   assert_predicate user, :valid?
  # end

  should validate_uniqueness_of(:email)

  test 'cannot be created when email exist' do
    user = create :user, email: 'admin@codesensei.pl'
    user2 = build :user, email: 'admin@codesensei.pl'
    assert_predicate user2, :valid?
  end
end
