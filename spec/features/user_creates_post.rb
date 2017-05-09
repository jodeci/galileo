# frozen_string_literal: true
require "rails_helper"

RSpec.feature "user creates post", type: :feature do
  scenario "user creates a new post" do
    given_i_have_logged_in
    when_i_create_a_post
    then_i_should_be_redirected_to_edit
    then_the_post_should_be_listed_in_dashboard
  end

  def given_i_have_logged_in
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  def when_i_create_a_post
    visit new_dashboard_post_path
    fill_in("title", with: "my awesome title")
    fill_in("slug", with: "slug")
    click_on("submit")
  end

  def then_i_should_be_redirected_to_edit
    expect(page).to have_current_path(edit_dashboard_post_path(Post.last.id))
  end

  def then_the_post_should_be_listed_in_dashboard
    visit dashboard_posts_path
    expect(page).to have_content("my awesome title")
  end
end
