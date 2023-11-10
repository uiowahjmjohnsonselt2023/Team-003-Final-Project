import { Turbo } from "@hotwired/turbo-rails"
import { cable } from "channels"
import { TurboDrive } from "@hotwired/turbo-rails"

Turbo.start()
TurboDrive.start()
cable.consumer.url = "/cable"

import "../stylesheets/products"
