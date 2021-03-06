# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160111173843) do

  create_table "details", force: :cascade do |t|
    t.integer  "venta_id"
    t.text     "producto"
    t.float    "cantidad"
    t.float    "precio"
    t.float    "precioventa"
    t.float    "descuento"
    t.float    "total"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "descuentoproveedor"
  end

  add_index "details", ["venta_id"], name: "index_details_on_venta_id"

  create_table "producto_padres", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "clave"
  end

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "clave"
    t.float    "precio"
    t.text     "descripcion"
    t.integer  "producto_padre_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.float    "venta"
    t.integer  "instalacion"
    t.integer  "instalacionpreencial"
    t.text     "busqueda"
  end

  add_index "productos", ["producto_padre_id"], name: "index_productos_on_producto_padre_id"

  create_table "rols", force: :cascade do |t|
    t.string   "nombre"
    t.string   "precio_hora"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "privilegio"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "venta", force: :cascade do |t|
    t.string   "cliente"
    t.string   "clave"
    t.date     "fecha"
    t.float    "iva"
    t.float    "subtotal"
    t.float    "total"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.float    "descuentogeneral"
    t.string   "distribuidor"
    t.float    "descuentodistribuido"
    t.string   "status"
    t.integer  "user_id"
  end

  add_index "venta", ["user_id"], name: "index_venta_on_user_id"

end
