require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe "バリデーションのテスト" do
    it "ニックネーム、メール、パスワードがあれば有効な状態であること" do
      expect(@user).to be_valid
    end

    it "ニックネームがなければ無効な状態であること" do
      @user.name = ""
      @user.valid?
      expect(@user.errors[:name]).to include("を入力してください")
    end

    it "ニックネームが3文字未満であれば無効であること" do
      @user.name = "a" * 2
      @user.valid?
      expect(@user.errors[:name]).to include("は2文字以上で入力してください")
    end

    it "ニックネームが20文字以下でなければ無効であること" do
      @user.name = "a" * 11
      @user.valid?
      expect(@user.errors[:name]).to include("は20文字以内で入力してください")
    end
    
    it "メールアドレスがなければ無効な状態であること" do
      @user.email = ""
      @user.valid?
      expect(@user.errors[:email]).to include("を入力してください")
    end

    it "メールアドレスが30文字以下でなければ無効な状態であること" do
      @user.email = "a" * 31
      @user.valid?
      expect(@user.errors[:email]).to include("は30文字以下で入力してください。")
    end
    
    it "電話番号が12文字以下でなければ無効な状態であること" do
      @user.phone_number = "a" * 13
      @user.valid?
      expect(@user.errors[:phone_number]).to include("は12文字以内で入力してください")
    end

    it "自己紹介文が150文字以下でなければ無効な状態であること" do
      @user.introduction = "a" * 201
      @user.valid?
      expect(@user.errors[:introduction]).to include("は150文字以内で入力してください")
    end

    it "パスワードが6文字以上でなければ無効であること" do
      @user.password = "a" * 5
      @user.valid?
      expect(@user.errors[:password]).to include("は6文字以上で入力してください。")
    end
    
    it "重複したメールアドレスなら無効な状態であること" do
      FactoryBot.create(:user)
      @user.valid?
      expect(@user.errors[:email]).to include("は既に存在します。")
    end
  end
end

