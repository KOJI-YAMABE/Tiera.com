require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_user_registration_path
    end
    context '新規登録' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: 'テスト太郎'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '新規登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '新規登録'
        expect(page).to have_content '入力してください'
      end
    end
  end
  describe 'ユーザーログインのテスト' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン' do
      it 'ログインに成功する' do
        login(user)
        expect(page).to have_content 'ログインしました。'
      end
      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
  describe 'マイページのテスト' do
    let(:user) { create(:user) }
    before do
      login(user)
      visit user_path(user)
    end
    it 'マイページと表示される' do
      expect(page).to have_content('マイページ')
    end
    it '画像が表示される' do
      expect(page).to have_css('img.attachment.user.profile_image.rounded-circle.fallback')
    end
    it '名前が表示される' do
      expect(page).to have_content(user.name)
    end
    it '編集リンクが表示される' do
      expect(page).to have_link '', href: edit_user_path(user)
    end
  end
  describe 'プロフィール編集のテスト' do
    let(:user) { create(:user) }
    before do
      login(user)
      visit edit_user_path(user)
    end
    it 'プロフィール編集画面への遷移' do
      expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
    end
    it 'プロフィール編集と表示される' do
      expect(page).to have_content('プロフィール編集')
    end
    it '名前編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[name]', with: user.name
    end
    it 'メールアドレス編集フォームに自分のメールアドレスが表示される' do
      expect(page).to have_field 'user[email]', with: user.email
    end
    context '編集' do
      it '編集に成功する' do
        click_button '編集内容を保存する'
        expect(page).to have_content 'プロフィールを更新しました。'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '編集内容を保存する'
        expect(page).to have_content '名前とメールアドレスを入力してください。'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end
  describe '退会のテスト' do
    let(:user) { create(:user) }
    before do
      login(user)
      visit users_confirm_path(user)
    end
    it '退会画面への遷移' do
      expect(current_path).to eq('/users/' + user.id.to_s + '/confirm')
    end
    it '本当に退会しますか？と表示される' do
      expect(page).to have_content('本当に退会しますか？')
    end
    it '退会に成功する' do
      click_on '退会する'
      expect(current_path).to eq('/')
    end
  end
  describe '一覧画面のテスト' do
    let(:user) { create(:user) }
    before do
      @takashi = create(:takashi)
      login(user)
      visit users_path
    end
    it 'ユーザー一覧と表示される' do
      expect(page).to have_content('ユーザー一覧')
    end
    it '自分の名前が表示される' do
      expect(page).to have_content user.name
    end
    it '他のユーザーの名前が表示される' do
      expect(page).to have_content @takashi.name
    end
  end
end
