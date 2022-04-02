export default () => ({
  feedback: "",

  onDrop(e: any): void {
    e.stopPropagation();
    e.preventDefault();
    this.$refs.fileToUpload.files = e.dataTransfer.files;
    this.onSubmit();
  },

  onSubmit(): void {
    this.feedback = "";
    const form = this.$refs.dropForm;
    const data = new FormData(form);

    const request = new XMLHttpRequest();
    request.open("POST", "upload", true);
    request.onload = (event) => {
      console.log(request.response);
      if (request.status !== 200) {
        this.feedback = `Error ${request.status}: ${request.statusText}`;
      }

      const response = JSON.parse(request.response);
      this.feedback = response.message;
    };

    request.send(data);
  },
});
