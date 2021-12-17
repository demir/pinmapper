class ReservedWords
  BASE_WORDS = %w[
    404
    500
    about
    account
    admin
    ads
    advertising
    anal
    analysis
    analytics
    api
    app
    blog
    chat
    csv_exports
    demir
    delete
    deryademir
    destroy
    edit
    emredemir
    facebook
    features
    followers
    following
    follows
    fuck
    fucker
    google
    guide
    guides
    help
    history
    image
    images
    instagram
    latest
    legal
    me
    members
    membership
    meta
    new
    news
    notifications
    online
    pinmapper
    privacy
    reports
    rss
    search
    settings
    sex
    tag
    tags
    terms
    twitter
    update
    uploads
    user
    users
    video
    videos
    youtube
    welcome
  ].freeze

  class << self
    def all
      @all || BASE_WORDS
    end

    attr_writer :all
  end
end
