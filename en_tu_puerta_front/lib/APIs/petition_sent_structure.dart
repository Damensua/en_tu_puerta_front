var messi = {
  "type": "petition",
  "id": 2,
  "attributes": {
    "id_user": 1,
    "description": "Rerum laborum nesciunt sed magni non sapiente.",
    "type": "Estilista general",
    "date": "2025-03-06",
    "time": "22:04:06",
    "status": "Sin respuesta",
    "message":
        "Ducimus et nihil repellendus. Nesciunt laboriosam ut incidunt quidem commodi reprehenderit. Hic labore cumque tempore praesentium velit repellat mollitia. Sed autem aut cum ratione.",
    "id_service": 7,
    "created_at": "2025-03-04T01:16:00.000000Z"
  },
  "relationships": {
    "client": {
      "data": {"type": "user", "id": 1},
      "links": [
        {"self": "http://127.0.0.1:8000/api/v1/users/1"}
      ]
    },
    "service": {
      "data": {"type": "service", "id": 7},
      "links": {"self": "http://127.0.0.1:8000/api/v1/services/7"}
    }
  },
  "includes": {
    "type": "user",
    "id": 1,
    "attributes": {
      "first_name": "Madison",
      "last_name": "Jerde",
      "username": "rodriguez.lonzo",
      "email": "osvaldo.kassulke@example.org",
      "address": "72647 Kailey Key\nNew Sallyhaven, NJ 89241-9132"
    }
  },
  "links": [
    {"self": "http://127.0.0.1:8000/api/v1/petitions/2"}
  ]
};
