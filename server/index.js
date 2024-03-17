const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');
const bodyParser = require('body-parser');
const multer = require('multer'); // For handling file uploads
const fileUpload = require('express-fileupload'); 

// Initialize Firebase Admin SDK
<<<<<<< HEAD
const serviceAccount = require('./config.json'); // Path to your service account key file
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://rugnaarth-cc2df-default-rtdb.firebaseio.com/' // Your Firebase project's database URL
=======
const serviceAccount = require('../config.json'); // Path to your service account key file
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://rugnaarth-cc2df-default-rtdb.firebaseio.com/', // Your Firebase project's database URL
  storageBucket: 'gs://rugnaarth-cc2df.appspot.com'
>>>>>>> 3bd77da46a8f02b4a2ac93a3ee1bd51f5ab73870
});

const app = express();
app.use(express.json());
app.use(cors());
// Define Realtime Database reference
const db = admin.database();
const rootRef = db.ref();

<<<<<<< HEAD
// Example route requiring authentication
app.get('/getd', (req, res) => {
  res.status(200).json({ message: 'Authenticated successfully'});
=======
app.use(bodyParser.json());
const upload = multer({ dest: 'uploads/' }); // Specify the directory where uploaded files will be stored
app.use(fileUpload());

// Define routes to handle data creation
// Route to create a new patient
app.post('/patients', async (req, res) => {
  try {
    // Create patient data
    const patientData = {
      name: req.body.name,
      photoUrl: req.body.photoUrl,
      age: req.body.age,
      sex: req.body.sex,
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
>>>>>>> 3bd77da46a8f02b4a2ac93a3ee1bd51f5ab73870
});

// Route to create a new doctor
app.post('/doctors', async (req, res) => {
  try {
    // Create doctor data
    const doctorData = {
      name: req.body.name,
      photoUrl: req.body.photoUrl,
      age: req.body.age,
      sex: req.body.sex,
      email: req.body.email,
      phoneNumber: req.body.phoneNumber,
      hospitalClinicAddress: req.body.hospitalClinicAddress,
      yearsOfExperience: req.body.yearsOfExperience,
      educationDegree: req.body.educationDegree,
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

app.post('/patients/:patientId/documents', async (req, res) => {
  const patientId = req.params.patientId;
  const documentFile = req.files.document; // Access uploaded file using req.files
  const doctorId = req.body.doctorId;

  // Check if patientId, doctorId, and documentFile are provided
  if (!patientId || !doctorId || !documentFile) {
    return res.status(400).json({ error: 'Patient ID, Doctor ID, and Document file are required.' });
  }

  const bucket = admin.storage().bucket();

  try {
    // Upload the document to Firebase Storage
    const timestamp = new Date().getTime();
    const fileName = `${patientId}_${timestamp}_${documentFile.name}`;
    const file = bucket.file(fileName);
    await file.save(documentFile.data, { contentType: documentFile.mimetype });

    // Get the public URL of the uploaded file
    const publicUrl = `https://storage.googleapis.com/${bucket.name}/${fileName}`;

    // Update the patient's document data
    const documentData = { link: publicUrl, doctorId: doctorId, uploadDate: new Date().toISOString() };
    await rootRef.child(`patients/${patientId}/documents`).push().set(documentData);

    res.status(200).json({ message: 'Document uploaded successfully.', url: publicUrl, doctorId: doctorId, uploadDate: documentData.uploadDate });
  } catch (error) {
    console.error('Error uploading document:', error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

//Following is exmaple of same as above document uplaodtion but to test i did not use document  upoadtion line feture 
//or specific mutler OKK Akshay!
// app.post('/patients/:patientId/documents', async (req, res) => {
//   const patientId = req.params.patientId;
//   const doctorId = req.body.doctorId; // Extract doctor ID from request body

//   // Check if patientId is provided
//   if (!patientId) {
//     return res.status(400).json({ error: 'Patient ID is required.' });
//   }

//   // Check if doctorId is provided
//   if (!doctorId) {
//     return res.status(400).json({ error: 'Doctor ID is required.' });
//   }

//   try {
//     // Update the patient's document array to include the document link, doctor ID, and upload date
//     const documentData = { doctorId: doctorId, uploadDate: new Date().toISOString() };
//     await rootRef.child(`patients/${patientId}/documents`).push().set(documentData);

//     res.status(200).json({ message: 'Document information added successfully.', doctorId: doctorId, uploadDate: documentData.uploadDate });
//   } catch (error) {
//     console.error('Error updating document information:', error);
//     res.status(500).json({ error: 'Something went wrong' });
//   }
// });


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
