using UnityEditor;
using UnityEngine;

public class UVAssigner : Editor
{
    [MenuItem("GameObject/Assign Lightmap UVs", false, 0)]
    public static void AssignSecondaryUVsMenuItem()
    {
        _AssignUvs(false);
    }

    [MenuItem("GameObject/Assign All UVs", false, 0)]
    public static void AssignAllUVsMenuItem()
    {
        _AssignUvs(true);
    }

    public static void _AssignUvs(bool alsoPrimary)
    {
        GameObject[] selectedObjects = Selection.gameObjects;

        if (selectedObjects.Length > 0)
        {
            for (int i = 0; i < selectedObjects.Length; i++)
            {
                AssignUVsToChildren(selectedObjects[i], i, selectedObjects.Length, alsoPrimary);
            }
        }
        else
        {
            Debug.LogWarning("No game objects selected.");
        }

        EditorUtility.ClearProgressBar();
    }

    private static void AssignUVsToChildren(GameObject parent, int currentObjIndex, int totalObjects, bool alsoPrimary)
    {
        MeshFilter[] meshFilters = parent.GetComponentsInChildren<MeshFilter>();

        for (int i = 0; i < meshFilters.Length; i++)
        {
            MeshFilter meshFilter = meshFilters[i];
            EditorUtility.DisplayProgressBar("Processing UVs", $"Processing {meshFilter.gameObject.name} ({currentObjIndex+1}/{totalObjects})", (float) i / meshFilters.Length);
            Unwrapping.GenerateSecondaryUVSet(meshFilter.sharedMesh);
            if (alsoPrimary)
            {
                meshFilter.sharedMesh.uv = meshFilter.sharedMesh.uv2;

                // var uvs = Unwrapping.GeneratePerTriangleUV(meshFilter.sharedMesh);
                // Debug.Log($"verts: {meshFilter.sharedMesh.vertices.Length} uv2: {meshFilter.sharedMesh.uv2.Length} uvs: {uvs.Length}");
                // // int[] triangles = new int[meshFilter.sharedMesh.triangles.Length];
                // // for (int i = 0; i < triangles.Length; i++) {
                // //     triangles[i] = i;
                // // }
                // // meshFilter.sharedMesh.triangles = triangles;
                // meshFilter.sharedMesh.uv = uvs;
            }
            EditorUtility.SetDirty(meshFilter.sharedMesh);
        }
    }
}