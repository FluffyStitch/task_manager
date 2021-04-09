import 'bootstrap'
import 'bootstrap-icons/font/bootstrap-icons'
import jquery from 'jquery'
import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../stylesheets/application'
import '../src/task'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.$ = window.jquery = jquery;
$(() => flatpickr(".datepicker", { minDate: 'today' }))
