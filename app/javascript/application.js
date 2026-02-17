import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  // PWA service worker
  if ("serviceWorker" in navigator) {
    navigator.serviceWorker.register("/service-worker.js")
  }

  // Completion animation (one-shot)
  const id = sessionStorage.getItem("ol_just_closed")
  if (!id) return

  const row = document.querySelector(`[data-task-row-id="${id}"]`)
  if (row) {
    row.classList.add("task--just-closed")
    window.setTimeout(() => row.classList.remove("task--just-closed"), 900)
  }
  sessionStorage.removeItem("ol_just_closed")
})
