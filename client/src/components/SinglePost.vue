<script lang="ts">
import { defineComponent } from 'vue'
import api from '../http.ts'

interface Post {
  title: string,
  body: string
}

export default defineComponent({
  data() {
    return {
      post: { title: "", body: "" },
      body: String
    }
  },

  methods: {
    async loadPost() {
      const response = await api.get("/posts/" + this.$route.params.id)
      this.post = response.data as Post
    },

    clearForm() {
      this.body = ""
    },

    async createComment() {
      await api.post("/comments", { post_id: this.$route.params.id, body: this.body })
      this.clearForm()
    }
  },

  async mounted() {
    this.clearForm()
    await this.loadPost()
  }
})
</script>

<template>
  <div>
    <h1>{{ post.title }}</h1>
    <div class="item-post">
      <div>{{ post.body }}</div>
    </div>
  </div>
  <h3>New Comment:</h3>
  <div class="form-post">

    <div>
      <label for="input-body">Comment:</label>
      <textarea id="input-body" v-model="body" />
    </div>
    <button @click="createComment">Create comment</button>
  </div>
</template>

<style scoped>
.form-post label {
  display: block;
}
.item-post {
  background-color: #303030;
  border-radius: 15px;
  padding: 15px;
  margin-bottom: 20px;
}
</style>