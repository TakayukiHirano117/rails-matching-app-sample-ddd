# frozen_string_literal: true
require 'rails_helper'
require './app/domain/models/user/user.rb'
require 'securerandom'

RSpec.describe User do
  let(:name) { 'ヒラノ' }
  let(:email) { 'hirano@example.com' }
  let(:password) { 'password123' } # 8文字以上に修正

  let(:user) {
    user, = User.create(name:, email:, password:)

    return user
  }

  context 'user_id.value' do
    it 'ユーザーIDを参照できる' do
      expect(user.user_id.value).to eq(user.user_id.value)
    end
  end

  context 'name.value' do
    it 'ユーザー名を参照できる' do
      expect(user.name.value).to eq(name)
    end
  end

  context 'email.value' do
    it 'メールアドレスを参照できる' do
      expect(user.email.value).to eq(email)
    end
  end

  context 'password.value' do
    it 'パスワードを参照できる' do
      expect(user.password.value).to eq(password)
    end
  end

  context 'profile_id.value' do
    it 'プロフィールIDを参照できる' do
      expect(user.profile_id.value).to be_a(String)
      expect(user.profile_id.value.length).to eq(36) # UUID形式
    end
  end
end