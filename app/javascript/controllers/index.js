// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import ClosureController from "./closure_controller"
application.register("closure", ClosureController)
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
