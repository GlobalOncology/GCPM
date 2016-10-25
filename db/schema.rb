# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161021110754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "city"
    t.string   "country_name"
    t.string   "country_code"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "line_1"
    t.text     "line_2"
    t.text     "line_3"
    t.string   "postcode"
    t.boolean  "primary",          default: false
    t.string   "state"
    t.string   "state_code"
    t.integer  "geonames_city_id"
    t.integer  "organization_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "country_id"
    t.index ["country_id"], name: "index_addresses_on_country_id", using: :btree
    t.index ["organization_id"], name: "index_addresses_on_organization_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "agrupations", force: :cascade do |t|
    t.integer  "layer_id"
    t.integer  "layer_group_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["layer_group_id"], name: "index_agrupations_on_layer_group_id", using: :btree
    t.index ["layer_id"], name: "index_agrupations_on_layer_id", using: :btree
  end

  create_table "cancer_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cancer_types_projects", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "cancer_type_id"
    t.index ["cancer_type_id"], name: "index_cancer_types_projects_on_cancer_type_id", using: :btree
    t.index ["project_id"], name: "index_cancer_types_projects_on_project_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "country_name"
    t.string   "region_name"
    t.string   "country_iso"
    t.string   "region_iso"
    t.string   "country_centroid"
    t.string   "region_centroid"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "country_iso_3"
  end

  create_table "db_backups", force: :cascade do |t|
    t.text     "notes"
    t.string   "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "website"
    t.text     "excerpt"
    t.text     "participants"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "private"
    t.boolean  "online"
    t.text     "address"
    t.text     "address2"
    t.string   "city"
    t.string   "country"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "postcode"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "follows", force: :cascade do |t|
    t.string   "followable_type",                 null: false
    t.integer  "followable_id",                   null: false
    t.string   "follower_type",                   null: false
    t.integer  "follower_id",                     null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "funders", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "project_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_funders_on_organization_id", using: :btree
    t.index ["project_id"], name: "index_funders_on_project_id", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "investigators", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "website"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id"
    t.boolean  "is_approved", default: false
    t.index ["user_id"], name: "index_investigators_on_user_id", using: :btree
  end

  create_table "layer_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "super_group_id"
    t.string   "slug"
    t.string   "layer_group_type"
    t.string   "category"
    t.boolean  "active"
    t.integer  "order"
    t.text     "info"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "layer_group_name"
  end

  create_table "layers", force: :cascade do |t|
    t.integer  "layer_group_id"
    t.string   "name",                           null: false
    t.string   "slug",                           null: false
    t.string   "layer_type"
    t.integer  "zindex"
    t.boolean  "active"
    t.integer  "order"
    t.string   "color"
    t.text     "info"
    t.string   "layer_provider"
    t.text     "css"
    t.text     "interactivity"
    t.float    "opacity"
    t.text     "query"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "locate_layer",   default: false
    t.string   "icon_class"
    t.boolean  "published",      default: true
    t.text     "legend"
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.string  "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.string   "sender_type"
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.string   "notified_object_type"
    t.integer  "notified_object_id"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
    t.index ["type"], name: "index_mailboxer_notifications_on_type", using: :btree
  end

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.string   "receiver_type"
    t.integer  "receiver_id"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "research_unit_id"
    t.integer  "membership_type",  default: 1
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["membership_type"], name: "index_memberships_on_membership_type", using: :btree
    t.index ["project_id"], name: "index_memberships_on_project_id", using: :btree
    t.index ["research_unit_id"], name: "index_memberships_on_research_unit_id", using: :btree
  end

  create_table "organization_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "acronym"
    t.string   "grid_id"
    t.string   "email_address"
    t.integer  "established"
    t.integer  "organization_type_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["grid_id"], name: "index_organizations_on_grid_id", using: :btree
    t.index ["organization_type_id"], name: "index_organizations_on_organization_type_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "project_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_types_projects", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "project_type_id"
    t.index ["project_id"], name: "index_project_types_projects_on_project_id", using: :btree
    t.index ["project_type_id"], name: "index_project_types_projects_on_project_type_id", using: :btree
  end

  create_table "project_updates", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_updates_on_project_id", using: :btree
  end

  create_table "project_users", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.boolean  "is_approved", default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["project_id", "user_id"], name: "index_project_users_on_project_id_and_user_id", unique: true, using: :btree
    t.index ["project_id"], name: "index_project_users_on_project_id", using: :btree
    t.index ["user_id"], name: "index_project_users_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "project_website"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "research_units", force: :cascade do |t|
    t.integer  "address_id"
    t.integer  "investigator_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["address_id", "investigator_id"], name: "index_research_units_on_address_id_and_investigator_id", unique: true, using: :btree
    t.index ["address_id"], name: "index_research_units_on_address_id", using: :btree
    t.index ["investigator_id"], name: "index_research_units_on_investigator_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "position"
    t.string   "twitter_account"
    t.string   "linkedin_account"
    t.string   "pubmed"
    t.string   "authentication_token"
    t.datetime "token_expires_at"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "identities", "users"
  add_foreign_key "investigators", "users"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
