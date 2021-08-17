def validate_person_register_form(data):
    errors = []
    
    if not 'name' in data:
        errors.append('Name is required')
    else:
        if len(data['name']) < 3:
            errors.append('Name must be at least 3 characters')
    if not 'username' in data:
        errors.append('Username is required')
    else:
        if len(data['username']) < 3:
            errors.append('Username must be at least 5 characters')
    if not 'password' in data:
        errors.append('Password is required')
    else:
        if len(data['password']) < 3:
            errors.append('Password must be at least 8 characters')
    return errors