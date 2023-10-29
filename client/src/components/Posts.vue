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
      posts: [] as Post[],
      title: String,
      body: String
    }
  },

  methods: {
    async loadPosts() {
      const response = await api.get("/posts")
      this.posts = response.data as Post[]
    },

    clearForm() {
      this.title = ""
      this.body = ""
    },

    async createPost() {
      await api.post("/posts", { title: this.title, body: this.body })
      this.clearForm()
      this.loadPosts()
    }
  },

  async mounted() {
    this.clearForm()
    await this.loadPosts()
  }
})
</script>

<template>
  New Post:
  <div>
    Title: <input type="text" v-model="title"><br />
    Body: <textarea v-model="body" /><br />
    <button @click="createPost">Create Post</button>
  </div>
  <h1>Posts</h1>

  <div v-for="post in posts">
    <div>
      <h3>{{ post.title }}</h3>
      <div>{{ post.body }}</div>
    </div>
  </div>
</template>