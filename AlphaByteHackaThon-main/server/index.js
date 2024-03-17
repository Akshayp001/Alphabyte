const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');
const bodyParser = require('body-parser');

// Initialize Firebase Admin SDK
const serviceAccount = require('../config.json'); // Path to your service account key file
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://rugnaarth-cc2df-default-rtdb.firebaseio.com/', // Your Firebase project's database URL
  storageBucket: 'gs://rugnaarth-cc2df.appspot.com'
});

const app = express();
app.use(express.json());
app.use(cors());
// Define Realtime Database reference
const db = admin.database();
const rootRef = db.ref();

app.use(bodyParser.json());

// Define routes to handle data creation
// Route to create a new patient
app.post('/patients', async (req, res) => {
  try {
    // Create patient data with default values if fields are missing
    const patientData = {
      name: req.body.name || null,
      photoUrl: req.body.photoUrl || null,
      age: req.body.age || null,
      sex: req.body.sex || null,
      previousAllergiesConditions: req.body.previousAllergiesConditions || [],
      previousPrescriptions: req.body.previousPrescriptions || [],
      currentPrescriptions: req.body.currentPrescriptions || [],
      previousAppointmentDiagnosis: req.body.previousAppointmentDiagnosis || [],
      currentDiagnosis: req.body.currentDiagnosis || [],
      documents: req.body.documents || [] // Add the documents field to patient data
    };

    // Generate a unique key for the new patient
    const patientKey = rootRef.child('patients').push().key;

    // Set patient data to the database under 'patients' node with the generated key
    await rootRef.child(`patients/${patientKey}`).set(patientData);

    res.status(201).json({ message: 'Patient created successfully', id: patientKey });
  } catch (error) {
    console.error('Error creating patient:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});
app.get('/users', async (req, res) => {
  try {
    // Fetch all patient data from the database
    const patientsSnapshot = await rootRef.child('patients').once('value');
    const patientsData = patientsSnapshot.val() || {};

    // Fetch all doctor data from the database
    const doctorsSnapshot = await rootRef.child('doctors').once('value');
    const doctorsData = doctorsSnapshot.val() || {};

    // Combine patient and doctor data
    const usersData = { patients: patientsData, doctors: doctorsData };

    res.status(200).json(usersData);
  } catch (error) {
    console.error('Error fetching users data:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});
 
// Route to create a new doctor
app.post('/doctors', async (req, res) => {
  try {
    // Create doctor data with default values if fields are missing
    const doctorData = {
      name: req.body.name || null,
      photoUrl: req.body.photoUrl || null,
      age: req.body.age || null,
      sex: req.body.sex || null,
      email: req.body.email || null,
      phoneNumber: req.body.phoneNumber || null,
      hospitalClinicAddress: req.body.hospitalClinicAddress || null,
      yearsOfExperience: req.body.yearsOfExperience || null,
      educationDegree: req.body.educationDegree || null,
      areasOfExpertise: req.body.areasOfExpertise || [], // Default to an empty array if not provided
      patientReviewsFeedback: req.body.patientReviewsFeedback || [] // Default to an empty array if not provided
      // Add other doctor fields here
    };

    // Generate a unique key for the new doctor
    const doctorKey = rootRef.child('doctors').push().key;

    // Set doctor data to the database under 'doctors' node with the generated key
    await rootRef.child(`doctors/${doctorKey}`).set(doctorData);

    res.status(201).json({ message: 'Doctor created successfully', id: doctorKey });
  } catch (error) {
    console.error('Error creating doctor:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

// Route to get patient data by patient ID
app.get('/patients/:patientId', async (req, res) => {
  try {
    const patientId = req.params.patientId;

    // Fetch patient data from the database
    const snapshot = await rootRef.child(`patients/${patientId}`).once('value');
    const patientData = snapshot.val();

    if (!patientData) {
      return res.status(404).json({ error: 'Patient not found' });
    }

    res.status(200).json(patientData);
  } catch (error) {
    console.error('Error fetching patient data:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

// Route to get doctor data by doctor ID
app.get('/doctors/:doctorId', async (req, res) => {
  try {
    const doctorId = req.params.doctorId;

    // Fetch doctor data from the database
    const snapshot = await rootRef.child(`doctors/${doctorId}`).once('value');
    const doctorData = snapshot.val();

    if (!doctorData) {
      return res.status(404).json({ error: 'Doctor not found' });
    }

    res.status(200).json(doctorData);
  } catch (error) {
    console.error('Error fetching doctor data:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

// Route to get all doctors details
app.get('/doctors', async (req, res) => {
  try {
    // Fetch all doctors data from the database
    const snapshot = await rootRef.child('doctors').once('value');
    const doctorsData = snapshot.val();

    if (!doctorsData) {
      return res.status(404).json({ error: 'No doctors found' });
    }

    res.status(200).json(doctorsData);
  } catch (error) {
    console.error('Error fetching doctors data:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

// Route to update patient data by patient ID
app.put('/patients/:patientId', async (req, res) => {
  try {
    const patientId = req.params.patientId;
    const updateData = req.body;

    // Update patient data in the database
    await rootRef.child(`patients/${patientId}`).update(updateData);

    res.status(200).json({ message: 'Patient data updated successfully' });
  } catch (error) {
    console.error('Error updating patient data:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

// Route to update doctor data by doctor ID
app.put('/doctors/:doctorId', async (req, res) => {
  try {
    const doctorId = req.params.doctorId;
    const updateData = req.body;

    // Update doctor data in the database
    await rootRef.child(`doctors/${doctorId}`).update(updateData);

    res.status(200).json({ message: 'Doctor data updated successfully' });
  } catch (error) {
    console.error('Error updating doctor data:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
