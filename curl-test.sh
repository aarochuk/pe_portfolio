post_response=$(curl -X POST http://localhost:5000/api/timeline_post -d 'name=Andrew&email=andrew@gmail.com&content=Testing my endpoints with postman and curl.')
get_response=$(curl http://localhost:5000/api/timeline_post)
echo "$get_response" | jq -e '.timeline_posts[] | select(.content == "Testing my endpoints with postman and curl.")' >/dev/null

if [ $? -eq 0 ]; then
  echo "Post request ran successfully."
else
  echo "Error post request did not run successfully."
fi

delete_response=$(curl -s -X DELETE http://localhost:5000/api/timeline_post)
echo "Delete response: $delete_response"