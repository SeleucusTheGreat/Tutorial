import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["name"];
    
    initialize() {}
    connect() {
        console.log("I am connected");
    }
    toggleForm(event) {
        console.log("I clicked the edit button.");
        event.preventDefault();
        event.stopPropagation();
        const formID = event.params["form"];
        const commentBodyID = event.params["body"];
        const form = document.getElementById(formID);
        
        form.classList.toggle("d-none");
        form.classList.toggle("mt-5");
        const commentBody = document.getElementById(commentBodyID);
        commentBody.classList.toggle("d-none");
    }

    getUserName() {
        console.log("reached the getUserName fuction");
        const element = this.nameTarget;
        const name = element.textContent;
        alert("you clicked on "+name);
    }
      
}
